import { Controller, Delete, Param, Post } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { User } from '@prisma/client';
import { Auth } from 'src/core/decorators/auth.decorator';
import { FollowProvider } from './follow.provider';

@Controller('follow')
@ApiTags('follow')
@ApiBearerAuth()
export class FollowController {
  constructor(private readonly followProvider: FollowProvider) {}

  @Post('user/:userId/follow')
  async followUser(@Auth() user: User, @Param('userId') followingId: string) {
    return await this.followProvider.follow(user.id, followingId);
  }

  @Delete('user/:userId/unfollow')
  async unfollowUser(@Auth() user: User, @Param('userId') followingId: string) {
    return await this.followProvider.unfollow(user.id, followingId);
  }

  @Post('user/:userId')
  async getFollows(@Param('userId') userId: string) {
    return await this.followProvider.getFollows(userId);
  }
}
