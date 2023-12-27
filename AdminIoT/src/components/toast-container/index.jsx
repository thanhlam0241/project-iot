/* eslint-disable */
import { SnackbarProvider } from 'notistack';

export default function ToastProvider({ children }) {
    return (
        <SnackbarProvider maxSnack={5}>
            {children}
        </SnackbarProvider>
    );
}