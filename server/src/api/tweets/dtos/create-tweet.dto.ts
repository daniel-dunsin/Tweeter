import { ApiProperty } from '@nestjs/swagger';
import { TweetMediaType } from '@prisma/client';
import { Type } from 'class-transformer';
import { IsArray, IsOptional, ValidateNested } from 'class-validator';
import { IsEnum, IsString } from 'src/core/decorators/validators.decorator';

export class TweetMediaDto {
  @IsEnum(TweetMediaType, false)
  type: TweetMediaType;

  @IsString(false)
  url: string;

  @IsString(true)
  publicId: string;
}

export class TweetDto {
  @IsString(true)
  text?: string;

  @IsArray()
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => TweetMediaDto)
  @ApiProperty({ type: [TweetMediaDto] })
  media: TweetMediaDto[];
}

export class CreateTweetDto {
  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => TweetDto)
  @ApiProperty({ type: [TweetDto] })
  @IsOptional()
  tweets: TweetDto[];
}
