import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';

@Injectable()
export class FollowService {
  constructor(private readonly prisma: PrismaService) {}

  async createFollow(data: Prisma.FollowCreateInput) {
    return await this.prisma.follow.create({ data });
  }

  async getFollow(where: Prisma.FollowWhereUniqueInput) {
    return await this.prisma.follow.findUnique({ where });
  }

  async getFollows(where: Prisma.FollowWhereInput) {
    return await this.prisma.follow.findMany({ where });
  }

  async deleteFollow(where: Prisma.FollowWhereUniqueInput) {
    return await this.prisma.follow.delete({ where });
  }
}
