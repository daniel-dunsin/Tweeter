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

    await this.prisma.$transaction(async (tx) => {
      createTweetDtos.tweets.map(async (tweet) => {
        const createdTweet = await this.tweetService.createTweet(
          {
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
            ...(createTweetDtos.location
              ? {
                  location: {
                    connectOrCreate: {
                      where: {
                        lng_lat: {
                          lng: createTweetDtos.location.lng,
                          lat: createTweetDtos.location.lat,
                        },
                      },
                      create: {
                        lng: createTweetDtos.location.lng,
                        lat: createTweetDtos.location.lat,
                        name: createTweetDtos.location.name,
                      },
                    },
                  },
                }
              : {}),

            ...(createdTweetIds.length > 0 && {
              parentTweet: {
                connect: {
                  id: createdTweetIds[createdTweetIds.length - 1],
                },
              },
            }),
          },
          tx,
        );

        if (tweet.text) {
          const [tags, mentions] = [
            this.extractHashTags(tweet.text),
            this.extractMentions(tweet.text),
          ];

          const mentionedUsers = await this.userService.getUsers({
            OR: mentions.map((mention) => ({
              userName: mention,
            })),
          });

          await Promise.all(
            tags.map(async (tag) => {
              const newTag = await this.tweetService.createHashTag(tag, tx);
              await this.tweetService.createHashTagUsage(
                {
                  tweet: { connect: { id: createdTweet.id } },
                  hashTag: { connect: { id: newTag.id } },
                },
                tx,
              );
            }),
          );

          await Promise.all(
            mentionedUsers.map(async (mention) => {
              await this.tweetService.createMention(
                {
                  userId: mention.id,
                  tweetId: createdTweet.id,
                },
                tx,
              );
            }),
          );
        }

        if (createdTweetIds.length > 0) {
          await this.tweetService.updateTweet(
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
            tx,
          );
        }

        createdTweetIds.push(createdTweet.id);
      });
    });

    return {
      success: true,
      message: 'tweet created',
    };
  }
}
