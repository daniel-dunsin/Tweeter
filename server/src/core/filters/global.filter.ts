import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { JsonWebTokenError } from '@nestjs/jwt';
import { Prisma } from '@prisma/client';
import { Response } from 'express';

@Catch()
export class GlobalFilter implements ExceptionFilter {
  catch(exception: any, host: ArgumentsHost) {
    console.log(exception);
    const ctx = host.switchToHttp();
    const res = ctx.getResponse() as Response;

    let message = 'Oops! An error occured';
    let statusCode = HttpStatus.INTERNAL_SERVER_ERROR;

    if (exception instanceof HttpException) {
      message = exception.message;
      statusCode = exception.getStatus();
    }

    if (exception instanceof Prisma.PrismaClientKnownRequestError) {
      if (exception.code == 'P2014' || exception.code == 'P2003') {
        message = `Foreign Key Error: ${exception.message}`;
      }
    }

    if (exception instanceof JsonWebTokenError) {
      message = exception.message;
      statusCode = HttpStatus.UNAUTHORIZED;
    }

    return res.status(200).json({ error: message, statusCode, success: false });
  }
}
