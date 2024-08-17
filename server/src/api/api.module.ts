import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { TokenModule } from './token/token.module';
import { CategoryModule } from './category/category.module';

@Module({
  imports: [UserModule, AuthModule, TokenModule, CategoryModule],
})
export class ApiModule {}
