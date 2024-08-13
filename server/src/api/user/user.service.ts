import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../shared/prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) {}

  async createUser(data: Prisma.UserCreateInput) {
    return await this.prisma.user.create({ data });
  }

  async getUser(where: Prisma.UserWhereInput) {
    return await this.prisma.user.findFirst({ where });
  }

  async getUsers(where: Prisma.UserWhereInput) {
    return await this.prisma.user.findMany({ where });
  }

  async updateUser(
    where: Prisma.UserWhereUniqueInput,
    update: Prisma.UserUpdateInput,
  ) {
    return await this.prisma.user.update({ where, data: update });
  }

  async deleteUser(where: Prisma.UserWhereUniqueInput) {
    return await this.prisma.user.delete({ where });
  }
}
