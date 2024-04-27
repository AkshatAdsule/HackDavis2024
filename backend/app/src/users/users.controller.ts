import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
  Req,
  Res,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiOkResponse,
} from '@nestjs/swagger';
import { UsersService } from './users.service';

@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async getUsers() {
    return this.usersService.getUsers();
  }

  @Get(':id')
  async getUserById(@Param('id') id: string) {
    return this.usersService.getUserById(id);
  }

  @Post()
  @ApiCreatedResponse()
  async createUser(@Body() data: { email: string; name: string }) {
    return this.usersService.createUser(data);
  }

  @Put(':id')
  @ApiOkResponse()
  async updateUser(
    @Param('id') id: string,
    @Body() data: { email: string; name: string },
  ) {
    return this.usersService.updateUser(id, data);
  }
}
