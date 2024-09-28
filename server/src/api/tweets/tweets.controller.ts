import { Body, Controller, Get, Post } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { TweetProvider } from './tweets.provider';
import { Auth, IsPublic } from 'src/core/decorators/auth.decorator';
import { User } from '@prisma/client';
import { CreateTweetDto } from './dtos/create-tweet.dto';

@Controller('tweets')
@ApiBearerAuth()
@ApiTags('tweets')
export class TweetsController {
  constructor(private readonly tweetsProvider: TweetProvider) {}

  @Post()
  async createTweets(
    @Auth() user: User,
    @Body() createTweetsDto: CreateTweetDto,
  ) {
    return await this.tweetsProvider.createTweets(user, createTweetsDto);
  }

  @Get()
  @IsPublic()
  async get() {
    return await this.tweetsProvider.getDummy();
  }
}
