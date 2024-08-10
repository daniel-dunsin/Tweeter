import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(private readonly prisma: PrismaService) {}

  async createAuth(data: Prisma.AuthCreateInput) {
    return await this.prisma.auth.create({ data });
  }

  async getAuth(where: Prisma.AuthWhereInput) {
    return await this.prisma.auth.findFirst({ where });
  }

  async updateAuth(
    where: Prisma.AuthWhereUniqueInput,
    data: Prisma.AuthUpdateInput,
  ) {
    return await this.prisma.auth.update({ where, data });
  }

  async deleteAuth(where: Prisma.AuthWhereUniqueInput) {
    return await this.prisma.auth.delete({ where });
  }

  async getJwtToken(where: Prisma.JwtTokenWhereUniqueInput) {
    return await this.prisma.jwtToken.findUnique({ where });
  }

  async upsertJwtToken(
    where: Prisma.JwtTokenWhereUniqueInput,
    data: Prisma.JwtTokenUpdateInput,
  ) {
    return await this.prisma.jwtToken.upsert({
      where,
      update: data,
      create: { ...where, ...data } as Prisma.JwtTokenCreateInput,
    });
  }
}
