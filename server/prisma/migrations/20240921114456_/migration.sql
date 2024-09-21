-- AlterEnum
ALTER TYPE "TweetMediaType" ADD VALUE 'gif';

-- AlterTable
ALTER TABLE "tweets_media" ALTER COLUMN "publicId" DROP NOT NULL;
