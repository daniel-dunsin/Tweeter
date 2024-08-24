import { Injectable, NotFoundException } from '@nestjs/common';
import { UserService } from './user.service';
import { UpdateUserDto } from './dtos/update-user.dto';
import { UtilService } from 'src/shared/utils/utils.service';

@Injectable()
export class UserProvider {
  constructor(
    private readonly userService: UserService,
    private readonly utilService: UtilService,
  ) {}

  async getUser(userId: string) {
    const data = await this.userService.getUser({ id: userId });

    if (!data) throw new NotFoundException('User not found');

    return {
      success: true,
      message: 'user retrieved successfully',
      data,
    };
  }

  async updateUserInterests(userId: string, interests: string[]) {
    const data = await this.userService.updateUser(
      { id: userId },
      {
        interests: {
          connect: interests.map((interest) => ({ id: interest })),
        },
      },
    );

    if (!data) throw new NotFoundException('User not found');

    return {
      success: true,
      message: 'User interests updated successfully',
      data,
    };
  }

  async updateUser(userId: string, updateUserDto: UpdateUserDto) {
    const data = await this.userService.updateUser(
      { id: userId },
      updateUserDto,
    );

    if (!data) throw new NotFoundException('User not found');

    return {
      success: true,
      message: 'User updated successfully',
      data,
    };
  }

  async updateUserDp(userId: string, picture: string) {
    const user = await this.userService.getUser({ id: userId });

    if (!user) throw new NotFoundException('User not found');

    const { secure_url, public_id } =
      await this.utilService.uploadAsset(picture);

    const prevPublicId = user.profilePictureId;

    const data = await this.userService.updateUser(
      { id: user.id },
      { profilePicture: secure_url, profilePictureId: public_id },
    );

    if (prevPublicId) await this.utilService.deleteAsset(prevPublicId);

    return {
      success: true,
      message: 'Profile picture updated',
      data,
    };
  }

  async updateUserCoverDp(userId: string, picture: string) {
    const user = await this.userService.getUser({ id: userId });

    if (!user) throw new NotFoundException('User not found');

    const { secure_url, public_id } =
      await this.utilService.uploadAsset(picture);

    const prevPublicId = user.coverPicture;

    const data = await this.userService.updateUser(
      { id: user.id },
      { coverPicture: secure_url, coverPictureId: public_id },
    );

    if (prevPublicId) await this.utilService.deleteAsset(prevPublicId);

    return {
      success: true,
      message: 'Cover picture updated',
      data,
    };
  }
}
