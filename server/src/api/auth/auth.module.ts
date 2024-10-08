import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { AuthProvider } from './auth.provider';
import { JwtModule } from '@nestjs/jwt';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { PrismaModule } from 'src/shared/prisma/prisma.module';
import { SharedModule } from 'src/shared/shared.module';
import { UserModule } from '../user/user.module';
import { TokenModule } from '../token/token.module';
import { MailModule } from 'src/shared/mail/mail.module';
import { APP_GUARD } from '@nestjs/core';
import { AuthGuard } from './guards/auth.guard';

@Module({
  imports: [
    JwtModule.registerAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory(configService: ConfigService) {
        const secret = configService.get<string>('JWT_SECRET');
        return {
          global: true,
          secret: Buffer.from(secret).toString('ascii'),
        };
      },
    }),
    PrismaModule,
    SharedModule,
    UserModule,
    TokenModule,
    MailModule,
    ConfigModule,
  ],
  controllers: [AuthController],
  providers: [
    AuthService,
    AuthProvider,
    {
      provide: APP_GUARD,
      useClass: AuthGuard,
    },
  ],
})
export class AuthModule {}
