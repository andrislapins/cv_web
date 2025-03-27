import { AxiosHeaders, type AxiosResponse } from 'axios'
import { JobControllerApi, EducationControllerApi } from '../generated'
import { jobsMock } from './mocks/job.mock'
import { educationsMock } from './mocks/education.mock'

function createAxiosResponse<T>(data: T): AxiosResponse<T> {
  return {
    data,
    status: 200,
    statusText: 'OK',
    headers: {},
    config: {
      headers: new AxiosHeaders(),
    },
  }
}

export const mockJobApi = {
  getAllJobs: () => Promise.resolve(createAxiosResponse(jobsMock)),
} as JobControllerApi

export const mockEducationApi = {
  getAllEducations: () => Promise.resolve(createAxiosResponse(educationsMock)),
} as EducationControllerApi
