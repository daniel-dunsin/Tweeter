import { IsString } from 'src/core/decorators/validators.decorator';

export class LoginDto {
  @IsString(false)
  credential: string;

  @IsString(false)
  password: string;
}
