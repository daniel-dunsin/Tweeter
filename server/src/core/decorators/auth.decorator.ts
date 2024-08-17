import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { User } from '@prisma/client';
import { isEmpty } from 'class-validator';
import { Request } from 'express';

export const IsPublic = Reflector.createDecorator<boolean>();

export const Auth = createParamDecorator(function (
  data: keyof User,
  ctx: ExecutionContext,
) {
  const req = ctx.switchToHttp().getRequest<Request>();

  return isEmpty(data) ? req.user : req.user[data];
});
