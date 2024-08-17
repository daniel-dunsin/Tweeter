import {
  CanActivate,
  ExecutionContext,
  ForbiddenException,
  Injectable,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Request } from 'express';
import { SignJwtDto } from '../dtos/jwt-sign.dto';
import { PrismaService } from 'src/shared/prisma/prisma.service';
import { Reflector } from '@nestjs/core';
import { IsPublic } from 'src/core/decorators/auth.decorator';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private readonly jwtService: JwtService,
    private readonly prisma: PrismaService,
    private readonly reflector: Reflector,
  ) {}

  async canActivate(context: ExecutionContext) {
    const ctx = context.switchToHttp();
    const req = ctx.getRequest<Request>();

    const isPublic = this.reflector.get(IsPublic, context.getHandler());

    if (isPublic) {
      return true;
    }

    const authToken = req.headers['authorization'];

    if (!authToken || !authToken.startsWith('Bearer ')) {
      throw new ForbiddenException('Invalid auth token');
    }

    const token = authToken.split(' ')[1];

    const decodedToken = await this.jwtService.verifyAsync<SignJwtDto>(token);

    if (!decodedToken) {
      throw new ForbiddenException('Token is expired or invalid');
    }

    const jwtToken = await this.prisma.jwtToken.findFirst({
      where: { accessToken: token },
      include: { user: true },
    });

    if (!jwtToken) {
      throw new ForbiddenException('Jwt Token is invalid or has expired');
    }

    req['user'] = jwtToken.user;

    return true;
  }
}
