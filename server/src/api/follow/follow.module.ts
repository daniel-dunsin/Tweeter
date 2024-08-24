import { Module } from '@nestjs/common';
import { FollowService } from './follow.service';
import { FollowProvider } from './follow.provider';
import { FollowController } from './follow.controller';
import { SharedModule } from 'src/shared/shared.module';
import { UserModule } from '../user/user.module';

@Module({
  imports: [SharedModule, UserModule],
  providers: [FollowService, FollowProvider],
  controllers: [FollowController],
  exports: [FollowService],
})
export class FollowModule {}
