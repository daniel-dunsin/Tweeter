import { BadRequestException, Injectable } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpDto } from './dtos/sign-up.dto';
import { UtilService } from 'src/shared/utils/utils.service';
import { UserService } from '../user/user.service';
import { TokenService } from '../token/token.service';
import { TokenTypes } from '@prisma/client';
import { EventEmitter2 } from '@nestjs/event-emitter';
import { AppEvents } from 'src/shared/events/event.enum';
import { ISendMailOptions } from 'src/shared/mail/interfaces/mail.interface';
import { LoginDto } from './dtos/login.dto';
import { JwtService } from '@nestjs/jwt';
import { SignJwtDto } from './dtos/jwt-sign.dto';

@Injectable()
export class AuthProvider {
  constructor(
    private readonly authService: AuthService,
    private readonly utilService: UtilService,
    private readonly userService: UserService,
    private readonly tokenService: TokenService,
    private readonly jwtService: JwtService,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  async signUp(signUpDto: SignUpDto) {
    const { email, password, dateOfBirth, name } = signUpDto;

    const authExists = await this.authService.getAuth({
      email,
    });

    if (authExists) {
      throw new BadRequestException(
        'Oops! A user with this email address already exists',
      );
    }

    const hashedPassword = await this.utilService.hashPassword(password);

    await this.authService.createAuth({
      email,
      password: hashedPassword,
    });

    await this.userService.createUser({ email, name, dateOfBirth });

    const otp = this.utilService.getOtp();

    await this.tokenService.createToken({
      type: TokenTypes.passwordResetToken,
      code: otp,
      email,
    });

    this.eventEmitter.emit(AppEvents.sendMail, {
      to: email,
      subject: 'Verify Email',
      template: 'verify-email',
      context: { name, code: otp },
    } as ISendMailOptions);

    return {
      success: true,
      message: 'Sign Up Successful',
    };
  }

  async login(loginDto: LoginDto) {
    const { credential, password } = loginDto;

    const userExists = await this.authService.getAuth({
      OR: [{ email: credential }],
    });

    if (!userExists) throw new BadRequestException('Invalid login credentials');

    if (!userExists.password)
      throw new BadRequestException('Login with google or reset your password');

    const passwordMatch = await this.utilService.comparePassword(
      password,
      userExists.password,
    );

    if (!passwordMatch)
      throw new BadRequestException('Invalid login credentials');

    const user = await this.userService.getUser({ email: userExists.email });

    const accessToken = await this.jwtService.signAsync(<SignJwtDto>{ user });
    await this.authService.upsertJwtToken({ userId: user.id }, { accessToken });

    return {
      success: true,
      message: 'Login successful',
      data: user,
      meta: {
        accessToken,
      },
    };
  }
}
