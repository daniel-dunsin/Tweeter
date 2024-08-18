import { Inject, Injectable } from '@nestjs/common';
import { genSalt, hash, compare } from 'bcryptjs';
import { UploadApiOptions, v2 } from 'cloudinary';
import { generate } from 'otp-generator';

@Injectable()
export class UtilService {
  constructor(@Inject('Cloudinary') private readonly cloudinary: typeof v2) {}

  async hashPassword(password: string) {
    const saltFactor = await genSalt(12);
    const hashedPassword = await hash(password, saltFactor);
    return hashedPassword;
  }

  async comparePassword(password: string, hash: string) {
    return await compare(password, hash);
  }

  getOtp() {
    return generate(6, {
      specialChars: false,
      lowerCaseAlphabets: false,
    });
  }

  async uploadAsset(file: string, options?: UploadApiOptions) {
    const { secure_url, public_id } = await this.cloudinary.uploader.upload(
      file,
      {
        folder: 'tweeter',
        ...options,
      },
    );

    return { secure_url, public_id };
  }

  async deleteAsset(public_id: string) {
    await this.cloudinary.uploader.destroy(public_id);
  }
}
