import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { UserModule } from '../user/user.module';
import { TweetService } from './tweets.service';
import { TweetsController } from './tweets.controller';
import { TweetProvider } from './tweets.provider';

@Module({
  imports: [SharedModule, UserModule],
  providers: [TweetService, TweetProvider],
  controllers: [TweetsController],
  exports: [],
})
export class TweetModule {}
