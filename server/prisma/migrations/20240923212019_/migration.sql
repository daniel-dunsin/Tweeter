-- DropForeignKey
ALTER TABLE "tweets" DROP CONSTRAINT "tweets_locationId_fkey";

-- AlterTable
ALTER TABLE "tweets" ALTER COLUMN "locationId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "tweets" ADD CONSTRAINT "tweets_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "tweet_location"("id") ON DELETE SET NULL ON UPDATE CASCADE;
