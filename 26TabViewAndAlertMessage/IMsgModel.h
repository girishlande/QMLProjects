#pragma once


class IMsgModel {

public:
    virtual ~IMsgModel() = default;

    enum Type {
        InfoMsg,   // Will show up in bottom right corner of PL
        ErrorMsg, // Will show up in bottom left corner of the viewer (above panel if applicable)
        WarningMsg
    };
 };
