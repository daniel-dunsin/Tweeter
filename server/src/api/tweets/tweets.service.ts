import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';
import { PrismaService } from 'src/shared/prisma/prisma.service';
import _ from 'lodash';
import { ITXClientDenyList } from '@prisma/client/runtime/library';

@Injectable()
export class TweetService {
  constructor(private readonly prisma: PrismaService) {}

  private readonly tweetInclude: Prisma.TweetInclude = {};

  async createTweet(
    data: Prisma.TweetCreateInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).tweet.create({ data });
  }

  async createTweets(
    data: Prisma.TweetCreateManyInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).tweet.createManyAndReturn({ data });
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

  async deleteTweet(
    where: Prisma.TweetWhereUniqueInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).tweet.delete({ where });
  }

  async createMedium(data: Prisma.TweetMediaCreateInput) {
    return await this.prisma.tweetMedia.create({ data });
  }

  async getMedia(data: Prisma.TweetMediaFindManyArgs) {
    return await this.prisma.tweetMedia.findMany(data);
  }

  async deleteTweetMedium(
    where: Prisma.TweetMediaWhereUniqueInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).tweetMedia.delete({ where });
  }

  async deleteTweetMedia(
    where: Prisma.TweetMediaWhereInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).tweetMedia.deleteMany({ where });
  }

  async createHashTag(
    text: string,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    const slug = _.kebabCase(text);

    let tag = await (tx ?? this.prisma).hashTag.findFirst({
      where: {
        slug,
      },
    });

    if (!tag) {
      tag = await (tx ?? this.prisma).hashTag.create({
        data: {
          text,
          slug,
        },
      });
    }

    return tag;
  }

  async createHashTagUsage(
    data: Prisma.HashTagUsageCreateInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    return await (tx ?? this.prisma).hashTagUsage.create({ data });
  }

  async createMention(
    data: Prisma.TweetMentionsWhereInput,
    tx?: Omit<PrismaClient, ITXClientDenyList>,
  ) {
    const queryInstance = tx ?? this.prisma;

    const mention = await queryInstance.tweetMentions.findFirst({
      where: {
        tweetId: data.tweetId,
        userId: data.userId,
      },
    });

    if (!mention)
      return await queryInstance.tweetMentions.create({
        data: {
          user: {
            connect: {
              id: data.userId as string,
            },
          },
          tweet: {
            connect: {
              id: data.tweetId as string,
            },
          },
        },
      });
    else
      return await queryInstance.tweetMentions.update({
        where: {
          id: mention.id,
        },
        data: {
          count: {
            increment: 1,
          },
        },
      });
  }
}
