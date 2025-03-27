import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import { MemoryRouter } from 'react-router-dom'
import { AxiosHeaders, type AxiosResponse } from 'axios'

import { EducationApiContext } from '../../contexts/EducationApiContext'
import { EducationControllerApi } from '../../generated/apis/education-controller-api'
import type { Education } from '../../generated/models/education'

import Educations from './Educations'

const educationsMock: Education[] = [
  { id: 1, degree: 'Bachelor', institution: 'LU' },
  { id: 2, degree: 'Master', institution: 'RTU' },
]

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

const mockEducationApiPartial: Partial<EducationControllerApi> = {
  getAllEducations: () => Promise.resolve(createAxiosResponse(educationsMock)),
}

const mockEducationApi = mockEducationApiPartial as EducationControllerApi

describe('Educations Page', () => {
  it('renders list of educations from mock API', async () => {
    render(
      <MemoryRouter>
        <EducationApiContext value={mockEducationApi}>
          <Educations />
        </EducationApiContext>
      </MemoryRouter>,
    )

    expect(await screen.findByText('Bachelor')).toBeInTheDocument()
    expect(await screen.findByText('Master')).toBeInTheDocument()
  })
})
