import { ApiProperty } from '@nestjs/swagger';
import { IsArray } from 'class-validator';
import { IsString } from 'src/core/decorators/validators.decorator';
import { v4 } from 'uuid';

export class UpdateUserDto {
  @IsString(true)
  name?: string;

  @IsString(true)
  bio?: string;

  @IsString(true)
  website?: string;

  @IsString(true)
  dateOfBirth?: string;
}

export class UpdateUserDPDto {
  @IsString(true)
  picture: string;
}

export class UpdateUserInterestsDto {
  @IsArray()
  @ApiProperty({ example: [v4()] })
  interests: string[];
}
