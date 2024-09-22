import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';
import _ from 'lodash';

@Injectable()
export class TweetService {
  constructor(private readonly prisma: PrismaService) {}

  private readonly tweetInclude: Prisma.TweetInclude = {};

  async createTweet(data: Prisma.TweetCreateInput) {
    return await this.prisma.tweet.create({ data });
  }

  async createTweets(data: Prisma.TweetCreateManyInput) {
    return await this.prisma.tweet.createManyAndReturn({ data });
  }

  async getRawTweets(data: Prisma.TweetFindManyArgs) {
    return await this.prisma.tweet.findMany(data);
  }

  async getTweets(data: Prisma.TweetFindManyArgs) {
    return await this.prisma.tweet.findMany({
      ...data,
      include: this.tweetInclude,
    });
  }

  async getTweet(data: Prisma.TweetFindFirstArgs) {
    return await this.prisma.tweet.findFirst({
      ...data,
      include: this.tweetInclude,
    });
  }

  async deleteTweet(where: Prisma.TweetWhereUniqueInput) {
    return await this.prisma.tweet.delete({ where });
  }

  async createMedium(data: Prisma.TweetMediaCreateInput) {
    return await this.prisma.tweetMedia.create({ data });
  }

  async getMedia(data: Prisma.TweetMediaFindManyArgs) {
    return await this.prisma.tweetMedia.findMany(data);
  }

  async deleteTweetMedium(where: Prisma.TweetMediaWhereUniqueInput) {
    return await this.prisma.tweetMedia.delete({ where });
  }

  async deleteTweetMedia(where: Prisma.TweetMediaWhereInput) {
    return await this.prisma.tweetMedia.deleteMany({ where });
  }

  async createHashTag(data: Prisma.HashTagCreateInput) {
    const slug = _.kebabCase(data.text);

    let tag = await this.prisma.hashTag.findFirst({ where: { slug } });

    if (!tag) {
      data.slug = slug;
      tag = await this.prisma.hashTag.create({ data });
    }

    await this.prisma.hashTagUsage.upsert({
      where: { hashTagId: tag.id },
    });
  }
}
