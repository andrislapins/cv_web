import { createContext, use } from 'react'
import { EducationControllerApi } from '../generated/apis/education-controller-api'

export const EducationApiContext = createContext<EducationControllerApi | null>(
  null,
)

export const useEducationApi = () => {
  const context = use(EducationApiContext)
  if (!context) {
    throw new Error(
      'useEducationApi must be used within EducationApiContext.Provider',
    )
  }
  return context
}
