import { configureStore } from '@reduxjs/toolkit'
// ...


export type AppDispatch = typeof store.dispatch;
export type RootState = ReturnType<typeof store.getState>;