import { Inject, Injectable } from '@nestjs/common';
import { Prisma, TweetMediaType } from '@prisma/client';
import { genSalt, hash, compare } from 'bcryptjs';
import { UploadApiOptions, v2 } from 'cloudinary';
import { generate } from 'otp-generator';
import { PrismaService } from '../prisma/prisma.service';
import { CLOUDINARY_PROVIDER } from './cloudinary.provider';
import { DefaultQueryDto } from '../dtos';
import { unlink } from 'fs/promises';

@Injectable()
export class UtilService {
  constructor(
    @Inject(CLOUDINARY_PROVIDER) private readonly cloudinary: typeof v2,
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

  async uploadFileAsset(file: Express.Multer.File) {
    const response = await this.uploadAsset(file.path);
    await unlink(file.path);

    return response;
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

  resolvePaginationQuery(query: DefaultQueryDto, count?: number) {
    const page = Number(query?.page ?? '1') || 1;
    const limit = Number(query?.limit ?? '20') || 20;
    const skip = (page - 1) * limit;
    let totalPages = Infinity;

    if (count) {
      totalPages = Math.ceil(count / limit);
    }

    return {
      skip,
      limit,
      count,
      totalPages,
    };
  }
}
