/*
  Warnings:

  - You are about to drop the `TweetLocation` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TweetMentions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "TweetLocation" DROP CONSTRAINT "TweetLocation_tweetId_fkey";

-- DropForeignKey
ALTER TABLE "TweetMentions" DROP CONSTRAINT "TweetMentions_tweetId_fkey";

-- DropForeignKey
ALTER TABLE "TweetMentions" DROP CONSTRAINT "TweetMentions_userId_fkey";

-- DropTable
DROP TABLE "TweetLocation";

-- DropTable
DROP TABLE "TweetMentions";

-- CreateTable
CREATE TABLE "tweet_mentions" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "tweetId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tweet_mentions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tweet_location" (
    "id" TEXT NOT NULL,
    "tweetId" TEXT NOT NULL,
    "lng" DECIMAL(65,30) NOT NULL,
    "lat" DECIMAL(65,30) NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tweet_location_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "tweet_location_tweetId_key" ON "tweet_location"("tweetId");

-- AddForeignKey
ALTER TABLE "tweet_mentions" ADD CONSTRAINT "tweet_mentions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tweet_mentions" ADD CONSTRAINT "tweet_mentions_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "tweets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tweet_location" ADD CONSTRAINT "tweet_location_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "tweets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
