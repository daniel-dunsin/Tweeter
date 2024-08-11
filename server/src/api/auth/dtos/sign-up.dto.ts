import {
  IsDate,
  IsEmail,
  IsString,
} from 'src/core/decorators/validators.decorator';

export class SignUpDto {
  @IsString(false)
  name: string;

  @IsEmail(false)
  email: string;

  @IsDate(false)
  dateOfBirth: string;

  @IsString(false)
  password: string;

  @IsString(false)
  userName: string;
}

export class CheckEmailDto {
  @IsEmail(false)
  email: string;
}

export class CheckUserNameDto {
  @IsString(false)
  userName: string;
}
