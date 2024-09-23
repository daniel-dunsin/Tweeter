import { Module } from '@nestjs/common';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { TokenModule } from './token/token.module';
import { CategoryModule } from './category/category.module';
import { FollowModule } from './follow/follow.module';
import { GifModule } from './gif/gif.module';
import { MediaModule } from './media/media.module';

@Module({
  imports: [
    UserModule,
    AuthModule,
    TokenModule,
    CategoryModule,
    FollowModule,
    GifModule,
    MediaModule,
  ],
})
export class ApiModule {}
