import { Inject, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { genSalt, hash, compare } from 'bcryptjs';
import { UploadApiOptions, v2 } from 'cloudinary';
import { generate } from 'otp-generator';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UtilService {
  constructor(
    @Inject('Cloudinary') private readonly cloudinary: typeof v2,
    private readonly prisma: PrismaService,
  ) {}

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

  async generateUniqueModelId(
    prefix: string,
    model: Prisma.ModelName,
    property?: string,
  ) {
    const digits = Math.floor(10000000 + Math.random() * 90000000);
    const uniqueId = `${prefix}-${digits}`;
    const result = await this.prisma[model.toLowerCase()].findMany({
      where: { [(property || 'unique_id') as any]: uniqueId },
    });

    if (result.length == 0) {
      return uniqueId;
    }

    return this.generateUniqueModelId(prefix, model, property);
  }

  addUrlProtocol(url: string) {
    if (!/^https?:\/\//i.test(url)) {
      return 'https://' + url;
    }
    return url;
  }
}
