import { Body, Controller, Get, Post, Put } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import {
  CheckCredentialDto,
  CheckEmailDto,
  CheckUserNameDto,
  SignUpDto,
  AuthWithGoogleDto,
} from './dtos/sign-up.dto';
import { AuthProvider } from './auth.provider';
import { LoginDto } from './dtos/login.dto';
import { VerifyEmailDto } from './dtos/verify-email.dto';
import {
  ChangePasswordDto,
  ConfirmPasswordResetCode,
  ForgotPasswordDto,
  ResetPasswordDto,
  VerifyPasswordDto,
} from './dtos/forgot-password.dto';
import { Auth, IsPublic } from 'src/core/decorators/auth.decorator';
import { User } from '@prisma/client';

@Controller('auth')
@ApiTags('auth')
export class AuthController {
  constructor(private readonly authProvider: AuthProvider) {}

  @Post('sign-up')
  @IsPublic()
  async signUp(@Body() signUpDto: SignUpDto) {
    return await this.authProvider.signUp(signUpDto);
  }

  @Post('login')
  @IsPublic()
  async login(@Body() loginDto: LoginDto) {
    return await this.authProvider.login(loginDto);
  }

  @Post('check-email')
  @IsPublic()
  async checkEmail(@Body() checkEmailDto: CheckEmailDto) {
    return await this.authProvider.checkEmail(checkEmailDto.email);
  }

  @Post('check-username')
  @IsPublic()
  async checkUserName(@Body() checkUserNameDto: CheckUserNameDto) {
    return await this.authProvider.checkUserName(checkUserNameDto.userName);
  }

  @Post('check-credential')
  @IsPublic()
  async checkCredential(@Body() checkCredentialDto: CheckCredentialDto) {
    return await this.authProvider.checkCredential(
      checkCredentialDto.credential,
    );
  }

  @Post('verify-email')
  @IsPublic()
  async verifyEmail(@Body() verifyEmailDto: VerifyEmailDto) {
    return await this.authProvider.verifyEmail(verifyEmailDto);
  }

  @Post('forgot-password')
  @IsPublic()
  async forgotPassword(@Body() forgotPasswordDto: ForgotPasswordDto) {
    return await this.authProvider.forgotPassword(forgotPasswordDto.credential);
  }

  @Post('forgot-password/confirm')
  @IsPublic()
  async confirmPasswordResetCode(
    @Body() confirmPasswordResetCodeDto: ConfirmPasswordResetCode,
  ) {
    return await this.authProvider.confirmPasswordResetCode(
      confirmPasswordResetCodeDto.code,
    );
  }

  @Post('forgot-password/reset')
  @IsPublic()
  async resetPassword(@Body() resetPasswordDto: ResetPasswordDto) {
    return await this.authProvider.resetPassword(resetPasswordDto);
  }

  @Post('google')
  @IsPublic()
  async authWithGoogle(@Body() authWithGoogleDto: AuthWithGoogleDto) {
    return await this.authProvider.authWithGoogle(
      authWithGoogleDto.accessToken,
    );
  }

  @Post('account/activate')
  async activateAccount(@Auth() user: User) {
    return await this.authProvider.activateAccount(user);
  }

  @Post('account/deactivate')
  async deActivateAccount(@Auth('id') userId: string) {
    return await this.authProvider.deActivateAcccount(userId);
  }

  @Get('sign-out')
  async logOut(@Auth('id') userId: string) {
    return await this.authProvider.logOut(userId);
  }

  @Post('change-password')
  async changePassword(
    @Body() changePasswordDto: ChangePasswordDto,
    @Auth() user: User,
  ) {
    return await this.authProvider.changePassword(user, changePasswordDto);
  }

  @Post('verify-password')
  async verifyPassword(
    @Body() verifyPasswordDto: VerifyPasswordDto,
    @Auth() user: User,
  ) {
    return await this.authProvider.verifyPassword(
      user,
      verifyPasswordDto.password,
    );
  }

  @Put('change-username')
  async changeUserName(
    @Body() changeUserNameDto: CheckUserNameDto,
    @Auth() user: User,
  ) {
    return await this.authProvider.changeUsername(
      user,
      changeUserNameDto.userName,
    );
  }

  @Put('change-email')
  async changeEmail(@Body() changeEmailDto: CheckEmailDto, @Auth() user: User) {
    return await this.authProvider.changeEmail(user, changeEmailDto.email);
  }
}
