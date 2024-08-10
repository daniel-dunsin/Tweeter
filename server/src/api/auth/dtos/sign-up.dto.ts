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
  dateOfBirth: Date;

  @IsString(false)
  password: string;
}

export class CheckEmailDto {
  @IsEmail(false)
  email: string;
}

export class CheckUserNameDto {
  @IsString(false)
  userName: string;
}
