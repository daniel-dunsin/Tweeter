import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { UserProvider } from './user.provider';
import { PrismaModule } from 'src/shared/prisma/prisma.module';
import { SharedModule } from 'src/shared/shared.module';

@Module({
  imports: [PrismaModule, SharedModule],
  controllers: [UserController],
  providers: [UserService, UserProvider],
  exports: [UserService],
})
export class UserModule {}
