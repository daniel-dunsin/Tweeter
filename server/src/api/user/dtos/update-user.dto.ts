import { ApiProperty } from '@nestjs/swagger';
import { IsArray } from 'class-validator';
import { IsString } from 'src/core/decorators/validators.decorator';
import { v4 } from 'uuid';

export class UpdateUserDto {
  @IsString(true)
  name?: string;
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
