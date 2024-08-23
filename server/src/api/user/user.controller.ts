import { Body, Controller, Get, Put } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { Auth } from 'src/core/decorators/auth.decorator';
import { UserProvider } from './user.provider';
import {
  UpdateUserDPDto,
  UpdateUserDto,
  UpdateUserInterestsDto,
} from './dtos/update-user.dto';

@Controller('user')
@ApiTags('user')
@ApiBearerAuth()
export class UserController {
  constructor(private readonly userProvider: UserProvider) {}

  @Get()
  async getUser(@Auth('id') userId: string) {
    return await this.userProvider.getUser(userId);
  }

  @Put()
  async updateUser(
    @Auth('id') userId: string,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return await this.userProvider.updateUser(userId, updateUserDto);
  }

  @Put('profile-picture')
  async updateUserDp(
    @Auth('id') userId: string,
    @Body() updateUserDtoDto: UpdateUserDPDto,
  ) {
    return await this.userProvider.updateUserDp(
      userId,
      updateUserDtoDto.picture,
    );
  }

  @Put('interests')
  async updateUserInterests(
    @Auth('id') userId: string,
    @Body() updateUserInterestsDto: UpdateUserInterestsDto,
  ) {
    return await this.userProvider.updateUserInterests(
      userId,
      updateUserInterestsDto.interests,
    );
  }
}
