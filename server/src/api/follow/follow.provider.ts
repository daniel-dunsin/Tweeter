import { Injectable, NotFoundException } from '@nestjs/common';
import { FollowService } from './follow.service';
import { UserService } from '../user/user.service';
import { arrayNotEmpty } from 'class-validator';
import { Prisma } from '@prisma/client';

@Injectable()
export class FollowProvider {
  constructor(
    private readonly followService: FollowService,
    private readonly userService: UserService,
  ) {}

  async follow(userId: string, followingId: string) {
    const follow = await this.followService.getFollow({
      followerId_followingId: {
        followerId: userId,
        followingId: followingId,
      },
    });

    if (follow) {
      throw new NotFoundException("You're already following this user");
    }

    await this.followService.createFollow({
      follower: { connect: { id: userId } },
      following: { connect: { id: followingId } },
    });

    return {
      success: true,
      message: 'followed user successfully',
    };
  }

  async unfollow(userId: string, followingId: string) {
    const follow = await this.followService.getFollow({
      followerId_followingId: {
        followerId: userId,
        followingId: followingId,
      },
    });

    if (!follow) {
      throw new NotFoundException("You're not following this user");
    }

    await this.followService.deleteFollow({
      followerId_followingId: {
        followerId: userId,
        followingId: followingId,
      },
    });

    return {
      success: true,
      message: 'unfollowed user successfully',
    };
  }

  async getFollows(userId: string) {
    const [_followers, _followings] = await Promise.all([
      this.followService.getFollows({
        followingId: userId,
      }),
      this.followService.getFollows({
        followerId: userId,
      }),
    ]);

    const [followers, followings, verifiedFollowers] = await Promise.all([
      this.userService.getUsers({
        OR: _followers.map(({ followerId }) => ({ id: followerId })),
      }),
      this.userService.getUsers({
        OR: _followings.map(({ followingId }) => ({ id: followingId })),
      }),
      this.userService.getUsers({
        OR: _followers.map(({ followerId }) => ({
          id: followerId,
          isVerified: true,
        })),
      }),
    ]);

    const data = { followers, followings, verifiedFollowers };

    return {
      success: true,
      message: 'follows fetched successfully',
      data,
    };
  }

  async getSuggestedFollows(userId: string) {
    const { interests } = await this.userService.getUser({ id: userId });

    let query: Prisma.UserWhereInput;

    if (arrayNotEmpty(interests)) {
      query = {
        interests: {
          some: { OR: interests.map((interest) => ({ id: interest.id })) },
        },
      };
    } else {
      query = {};
    }

    const data = await this.userService.getUsers(query);

    return {
      success: true,
      message: 'get suggested follows successful',
      data,
    };
  }
}
