import { Configuration } from '../generated/configuration'
import { JobControllerApi } from '../generated/apis/job-controller-api'
import { EducationControllerApi } from '../generated/apis/education-controller-api'

const basePath = 'http://localhost:8080'
console.log(`📡 Connecting frontend to backend API at: ${basePath}`)
const configuration = new Configuration({ basePath })

export const jobApi = new JobControllerApi(configuration)
export const educationApi = new EducationControllerApi(configuration)
