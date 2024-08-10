import { IsEmail, IsString } from 'src/core/decorators/validators.decorator';

export class VerifyEmailDto {
  @IsEmail(false)
  email: string;
  @IsString(false)
  code: string;
}
