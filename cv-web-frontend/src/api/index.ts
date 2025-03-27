import { Configuration } from '../generated/configuration'
import { JobControllerApi } from '../generated/apis/job-controller-api'
import { EducationControllerApi } from '../generated/apis/education-controller-api'

const configuration = new Configuration({
  basePath: 'http://localhost:8080',
})

export const jobApi = new JobControllerApi(configuration)
export const educationApi = new EducationControllerApi(configuration)
