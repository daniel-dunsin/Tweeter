import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { AuthProvider } from './auth.provider';

@Module({
  controllers: [AuthController],
  providers: [AuthService, AuthProvider],
})
export class AuthModule {}
