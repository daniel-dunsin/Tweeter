import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';

@Injectable()
export class TokenService {
  constructor(private readonly prisma: PrismaService) {}

  async createToken(data: Prisma.TokenCreateInput) {
    return await this.prisma.token.create({ data });
  }

  async getTokens(where: Prisma.TokenWhereInput) {
    return await this.prisma.token.findMany({ where });
  }

  async getToken(where: Prisma.TokenWhereInput) {
    return await this.prisma.token.findFirst({ where });
  }

  async updateToken(
    where: Prisma.TokenWhereUniqueInput,
    update: Prisma.TokenUpdateInput,
  ) {
    return await this.prisma.token.update({ where, data: update });
  }

  async upsertToken(
    where: Prisma.TokenWhereUniqueInput | Prisma.TokenWhereInput,
    update: Prisma.TokenUpdateInput,
  ) {
    return await this.prisma.token.upsert({
      where: where as Prisma.TokenWhereUniqueInput,
      update,
      create: { ...where, ...update } as Prisma.TokenCreateInput,
    });
  }

  async deleteToken(where: Prisma.TokenWhereUniqueInput) {
    return await this.prisma.token.delete({ where });
  }
}
