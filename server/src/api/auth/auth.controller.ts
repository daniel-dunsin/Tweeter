import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { CheckEmailDto, CheckUserNameDto, SignUpDto } from './dtos/sign-up.dto';
import { AuthProvider } from './auth.provider';
import { LoginDto } from './dtos/login.dto';
import { VerifyEmailDto } from './dtos/verify-email.dto';

@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(private readonly authProvider: AuthProvider) {}

  @Post('sign-up')
  async signUp(@Body() signUpDto: SignUpDto) {
    return await this.authProvider.signUp(signUpDto);
  }

  @Post('login')
  async login(@Body() loginDto: LoginDto) {
    return await this.authProvider.login(loginDto);
  }

  @Post('check-email')
  async checkEmail(@Body() checkEmailDto: CheckEmailDto) {
    return await this.authProvider.checkEmail(checkEmailDto.email);
  }

  @Post('check-username')
  async checkUserName(@Body() checkUserNameDto: CheckUserNameDto) {
    return await this.authProvider.checkUserName(checkUserNameDto.userName);
  }

  @Post('verify-email')
  async verifyEmail(@Body() verifyEmailDto: VerifyEmailDto) {
    return await this.authProvider.verifyEmail(verifyEmailDto);
  }
}
