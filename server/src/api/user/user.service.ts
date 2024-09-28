import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../shared/prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) {}

  populateOptions: Prisma.UserInclude = {
    interests: { include: { category: true } },
    followers: { include: { follower: true, following: true } },
    followings: { include: { follower: true, following: true } },
    _count: {
      select: {
        tweets: true,
      },
    },
  };

  async createUser(data: Prisma.UserCreateInput) {
    return await this.prisma.user.create({
      data,
      include: this.populateOptions,
    });
  }

  async getUser(where: Prisma.UserWhereInput) {
    return await this.prisma.user.findFirst({
      where,
      include: this.populateOptions,
    });
  }

  async getUsers(where: Prisma.UserWhereInput) {
    return await this.prisma.user.findMany({
      where,
      include: this.populateOptions,
    });
  }

  async updateUser(
    where: Prisma.UserWhereUniqueInput,
    update: Prisma.UserUpdateInput,
  ) {
    return await this.prisma.user.update({
      where,
      data: update,
      include: this.populateOptions,
    });
  }

  async deleteUser(where: Prisma.UserWhereUniqueInput) {
    return await this.prisma.user.delete({
      where,
      include: this.populateOptions,
    });
  }

  async createFollow(data: Prisma.FollowCreateInput) {
    return await this.prisma.follow.create({ data });
  }

  async getFollows(where: Prisma.FollowWhereInput) {
    return await this.prisma.follow.findMany({ where });
  }
}
