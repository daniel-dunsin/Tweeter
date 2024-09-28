import { Injectable } from '@nestjs/common';
import { TweetService } from './tweets.service';
import { User } from '@prisma/client';
import { CreateTweetDto } from './dtos/create-tweet.dto';
import { UserService } from '../user/user.service';
import { PrismaService } from 'src/shared/prisma/prisma.service';

@Injectable()
export class TweetProvider {
  constructor(
    private readonly tweetService: TweetService,
    private readonly userService: UserService,
    private readonly prisma: PrismaService,
  ) {}

  private readonly hashTagMatcher = /#[a-zA-Z0-9_]+/g;
  private readonly mentionsMathcer = /@[a-zA-Z0-9_]+/g;
  private extractHashTags(text: string): string[] {
    return text.match(this.hashTagMatcher)?.map((tag) => tag.slice(1)) || [];
  }
  private extractMentions(text: string): string[] {
    return (
      text.match(this.mentionsMathcer)?.map((mention) => mention.slice(1)) || []
    );
  }

  async createTweets(user: User, createTweetDtos: CreateTweetDto) {
    const createdTweetIds = [];

    await Promise.all(
      createTweetDtos.tweets.map(async (tweet) => {
        let createdTweet = await this.tweetService.createTweet({
          text: tweet.text,
          media: {
            createMany: {
              data: tweet.media,
            },
          },
          tweeter: {
            connect: {
              id: user.id,
            },
          },
          ...(createdTweetIds.length > 0 && {
            parentTweet: {
              connect: {
                id: createdTweetIds[createdTweetIds.length - 1],
              },
            },
          }),
        });

        if (tweet.text) {
          const [tags, mentions] = [
            this.extractHashTags(tweet.text),
            this.extractMentions(tweet.text),
          ];

          const mentionedUsers = await this.userService.getUsers({
            OR: mentions.map((mention) => ({
              userName: {
                equals: mention,
                mode: 'insensitive',
              },
            })),
          });

          await Promise.all(
            tags.map(async (tag) => {
              const newTag = await this.tweetService.createHashTag(tag);
              await this.tweetService.createHashTagUsage({
                tweet: {
                  connect: {
                    id: createdTweet.id,
                  },
                },
                hashTag: {
                  connect: {
                    id: newTag.id,
                  },
                },
              });
            }),
          );

          await Promise.all(
            mentionedUsers.map(async (mention) => {
              await this.tweetService.createMention({
                userId: mention.id,
                tweetId: createdTweet.id,
              });
            }),
          );
        }

        if (createdTweetIds.length > 0) {
          createdTweet = await this.tweetService.updateTweet(
            {
              id: createdTweetIds[createdTweetIds.length - 1],
            },
            {
              childTweets: {
                connect: {
                  id: createdTweet.id,
                },
              },
            },
          );
        }

        createdTweetIds.push(createdTweet.id);

        return createdTweet;
      }),
    );

    return {
      success: true,
      message: 'tweet created',
    };
  }

  async getUserTweets(userId: string) {
    const default_args = this.tweetService.multipleTweetsDefaultArgs;

    const [posts, replies, media, likes] = await Promise.all([
      this.tweetService.getTweets({
        ...default_args,
        where: {
          tweeterId: userId,
        },
      }),
      this.tweetService.getTweets({
        ...default_args,
        where: {
          parentTweetId: {
            not: null,
          },
          parentTweet: {
            tweeterId: {
              not: userId,
            },
          },
        },
      }),
      this.tweetService.getTweets({
        ...default_args,
        where: {
          tweeterId: userId,
          media: {
            some: {},
          },
        },
      }),
      this.tweetService.getTweets({
        ...default_args,
        where: {
          likersIds: {
            has: userId,
          },
        },
      }),
    ]);

    const data = {
      posts,
      replies,
      media,
      likes,
    };

    return {
      success: true,
      message: 'user tweets fetched successfully',
      data,
    };
  }

  async getHomePageTweets(userId: string) {
    const default_args = this.tweetService.multipleTweetsDefaultArgs;

    const { interests } = await this.userService.getUser({ id: userId });

    const [forYou, following] = await Promise.all([
      this.tweetService.getTweets({
        ...default_args,
        where: {
          tweeter: {
            interests: {
              some: {
                id: {
                  in: interests.map(({ id }) => id),
                },
              },
            },
          },
        },
      }),

      this.tweetService.getTweets({
        ...default_args,
        where: {
          tweeter: {
            followers: {
              some: {
                followerId: {
                  equals: userId,
                },
              },
            },
          },
        },
      }),
    ]);

    const data = {
      forYou,
      following,
    };

    return {
      success: true,
      message: 'Home page tweets fetched',
      data,
    };
  }

  async getTweetComments(tweetId: string) {
    const data = await this.tweetService.getTweets({
      ...this.tweetService.multipleTweetsDefaultArgs,
      where: {
        parentTweetId: tweetId,
      },
    });

    return {
      success: true,
      message: 'Tweet Comments fetched',
      data,
    };
  }

  async getDummy() {
    const data = await this.tweetService.getTweets({
      ...this.tweetService.multipleTweetsDefaultArgs,
    });

    return {
      success: true,
      message: '',
      data,
    };
  }
}
