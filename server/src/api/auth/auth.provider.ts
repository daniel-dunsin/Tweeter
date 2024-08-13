import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
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
import { VerifyEmailDto } from './dtos/verify-email.dto';
import { ResetPasswordDto } from './dtos/forgot-password.dto';

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
    const { email, password, dateOfBirth, name, userName } = signUpDto;

    const authExists = await this.authService.getAuth({
      OR: [{ email }, { userName }],
    });

    if (authExists) {
      throw new BadRequestException(
        'Oops! A user with this email address or username already exists',
      );
    }

    const hashedPassword = await this.utilService.hashPassword(password);

    await this.authService.createAuth({
      email,
      password: hashedPassword,
      userName,
    });

    await this.userService.createUser({ email, name, dateOfBirth, userName });

    const otp = this.utilService.getOtp();

    await this.tokenService.upsertToken(
      {
        type: TokenTypes.accountVerificationToken,
        email,
      },
      { code: otp },
    );

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
      OR: [{ email: credential }, { userName: credential }],
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

  async checkEmail(email: string) {
    const userExists = await this.authService.getAuth({ email });

    return {
      success: true,
      message: 'Check email successful',
      data: {
        exists: !!userExists,
      },
    };
  }
  async checkUserName(userName: string) {
    const userExists = await this.authService.getAuth({ userName });

    return {
      success: true,
      message: 'check username successful',
      data: {
        exists: !!userExists,
      },
    };
  }

  async verifyEmail(verifyEmailDto: VerifyEmailDto) {
    const { email, code } = verifyEmailDto;

    const token = await this.tokenService.getToken({
      email,
      code,
      type: TokenTypes.accountVerificationToken,
    });

    if (!token) throw new NotFoundException('otp is invalid');

    await this.authService.updateAuth({ email }, { isVerified: true });
    await this.tokenService.deleteToken({ id: token.id });

    const user = await this.userService.getUser({ email });

    const accessToken = await this.jwtService.signAsync(<SignJwtDto>{ user });
    await this.authService.upsertJwtToken({ userId: user.id }, { accessToken });

    return {
      success: true,
      message: 'Account verified successfully',
      data: user,
      meta: {
        accessToken,
      },
    };
  }

  async checkCredential(credential: string) {
    const userExists = await this.authService.getAuth({
      OR: [{ userName: credential }, { email: credential }],
    });

    return {
      success: true,
      message: 'user exists',
      data: {
        exists: !!userExists,
      },
    };
  }

  async forgotPassword(credential: string) {
    const user = await this.userService.getUser({
      OR: [{ email: credential }, { userName: credential }],
    });

    if (!user) throw new NotFoundException('Account does not exist');

    const otp = this.utilService.getOtp();

    await this.tokenService.upsertToken(
      {
        email: user.email,
        type: TokenTypes.passwordResetToken,
      },
      { code: otp },
    );

    this.eventEmitter.emit(AppEvents.sendMail, {
      to: user.email,
      subject: 'Tweeter: Password reset code',
      template: 'reset-password',
      context: {
        name: user.name,
        code: otp,
      },
    } as ISendMailOptions);

    return {
      success: true,
      message: 'password reset request successful',
    };
  }

  async confirmPasswordResetCode(code: string) {
    const token = await this.tokenService.getToken({
      code,
      type: TokenTypes.passwordResetToken,
    });

    if (!token) throw new NotFoundException('token is invalid');

    return {
      success: true,
      message: 'password reset code valid',
    };
  }

  async resetPassword(resetPasswordDto: ResetPasswordDto) {
    const { password, code } = resetPasswordDto;

    const token = await this.tokenService.getToken({
      code,
      type: TokenTypes.passwordResetToken,
    });

    if (!token) throw new NotFoundException('token is invalid');

    const hashedPassword = await this.utilService.hashPassword(password);

    await this.authService.updateAuth(
      { email: token.email },
      { password: hashedPassword },
    );

    return {
      success: true,
      message: 'password reset successful',
    };
  }
}
