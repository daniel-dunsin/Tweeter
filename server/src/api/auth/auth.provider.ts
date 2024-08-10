import { BadRequestException, Injectable } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignUpDto } from './dtos/sign-up.dto';
import { UtilService } from 'src/shared/utils/utils.service';
import { UserService } from '../user/user.service';
import { TokenService } from '../token/token.service';
import { TokenTypes } from '@prisma/client';

@Injectable()
export class AuthProvider {
  constructor(
    private readonly authService: AuthService,
    private readonly utilService: UtilService,
    private readonly userService: UserService,
    private readonly tokenService: TokenService,
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
  }

  async login() {}
}
