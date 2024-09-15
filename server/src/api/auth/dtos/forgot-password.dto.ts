import { IsString } from 'src/core/decorators/validators.decorator';

export class ForgotPasswordDto {
  @IsString(false)
  credential: string;
}

export class ConfirmPasswordResetCode {
  @IsString(false)
  code: string;
}

export class ResetPasswordDto {
  @IsString(false)
  code: string;

  @IsString(false)
  password: string;
}

export class ChangePasswordDto {
  @IsString(false)
  newPassword: string;

  @IsString(false)
  oldPassword: string;
}

export class VerifyPasswordDto {
  @IsString(false)
  password: string;
}
