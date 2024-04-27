import { ContainerClient, BlobServiceClient } from '@azure/storage-blob';
import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { v4 as uuidv4 } from 'uuid';

@Injectable()
export class StorageService {
  horsePhotosContainerClient: ContainerClient;
  constructor(config: ConfigService) {
    
  }

  async uploadPhotos(
    horseId: number,
    photos: Express.Multer.File[],
  ): Promise<string[]> {
    const uploadedUrls: string[] = [];

    // upload photos concurrently while preserving mime type and generate a unique name using uuid for each photo, finally push the urls to an array
    return uploadedUrls;
  }
}
