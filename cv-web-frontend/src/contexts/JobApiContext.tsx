import { createContext, use } from 'react'
import { JobControllerApi } from '../generated/apis/job-controller-api'

export const JobApiContext = createContext<JobControllerApi | null>(null)

export const useJobApi = () => {
  const context = use(JobApiContext)
  if (!context) {
    throw new Error('useJobApi must be used within JobApiContext.Provider')
  }
  return context
}
