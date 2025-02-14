package com.tmmas.scl.gestionlc.web.action.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.gestionlc.web.action.base.AbstractAction;

public class CerrarAction extends AbstractAction {

    protected ActionForward doPerform(ActionMapping pMapping, ActionForm pForm, HttpServletRequest pRequest, HttpServletResponse pHttpResponse)
            throws Exception {

        // pRequest.getSession().invalidate();

        return pMapping.findForward("success");
    }

    protected boolean noSessionForward(HttpServletRequest request) {
        return false;
    }

}
