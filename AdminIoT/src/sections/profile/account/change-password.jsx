/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable perfectionist/sort-imports */
/* eslint-disable perfectionist/sort-named-imports */
/* eslint-disable import/order */
/* eslint-disable */
import * as React from 'react';

import { Stack } from '@mui/material';
import { useCallback, useState } from 'react';
import {
    Button,
    Card,
    CardActions,
    CardContent,
    CardHeader,
    Divider,
    TextField
} from '@mui/material';

export default function ChangePassword(){
    const [values, setValues] = useState({
        password: '',
        confirm: '',
        oldPassword: ''
    });
    const handleChange = useCallback(
        (event) => {
            setValues((prevState) => ({
                ...prevState,
                [event.target.name]: event.target.value
            }));
        },
        []
    );

    const handleSubmit = useCallback(
        (event) => {
            event.preventDefault();
        },
        []
    );
    return (
        <form style={{ marginTop: 10 }} onSubmit={handleSubmit}>
            <Card>
                <CardHeader
                    subheader="Thay đổi mật khẩu"
                    title="Mật khẩu"
                />
                <Divider />
                <CardContent>
                    <Stack
                        spacing={3}
                        sx={{ maxWidth: 400 }}
                    >
                        <TextField
                            fullWidth
                            label="Mật khẩu cũ"
                            name="password"
                            onChange={handleChange}
                            type="password"
                            value={values.oldPassword}
                        />
                        <TextField
                            fullWidth
                            label="Mật khẩu mới"
                            name="password"
                            onChange={handleChange}
                            type="password"
                            value={values.password}
                        />
                        <TextField
                            fullWidth
                            label="Xác nhận mật khẩu mới"
                            name="confirm"
                            onChange={handleChange}
                            type="password"
                            value={values.confirm}
                        />
                    </Stack>
                </CardContent>
                <Divider />
                <CardActions sx={{ justifyContent: 'flex-end' }}>
                    <Button variant="contained">
                        Cập nhật
                    </Button>
                </CardActions>
            </Card>
        </form>
    )
}