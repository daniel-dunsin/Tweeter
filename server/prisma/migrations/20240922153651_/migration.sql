/*
  Warnings:

  - Added the required column `tweetId` to the `TweetMentions` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "TweetMentions" ADD COLUMN     "tweetId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "TweetMentions" ADD CONSTRAINT "TweetMentions_tweetId_fkey" FOREIGN KEY ("tweetId") REFERENCES "tweets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
